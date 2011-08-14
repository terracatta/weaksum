class Item < ActiveRecord::Base
  
  has_many :instances
  has_many :metadata
  
  MD5_REGEX = /^[0-9a-f]{32}$/
  SHA1_REGEX = /^[0-9a-f]{40}$/
  SHA256_REGEX = /^[0-9a-f]{64}$/
  FUZZY_REGEX = /^[0-9]+:[^:]+:[^:]+$/
  
  UNIQUENESS_ERROR = "The same file has already been uploaded previously."
  METADATA_IGNORE_LIST = 
  [
    'FileName',
    'Directory',
    'FileSize',
    'FilePermissions',
    'FileModifyDate',
    'ExifToolVersion',
    'Error'
  ]
  
  has_attached_file :upload
  
  validates :description, :length => { :maximum => 500 }
  validates :md5, :uniqueness => { :message => UNIQUENESS_ERROR }
  validates :sha256, :uniqueness => { :message => UNIQUENESS_ERROR }
  validates :sha1, :uniqueness => { :message => UNIQUENESS_ERROR }
  validates_attachment_presence :upload
  validates_attachment_size :upload, :less_than => 100.megabytes
    
  before_save do
    generate_hashes! unless all_hashes_generated?
  end
  
  after_create do
    generate_metadata
  end
  
  def self.find_by_hash(hash, hash_type=nil)
    search_type = hash_type ||= hash_type(hash)
    case search_type.to_sym
    when :md5
      self.find_by_md5(hash)  
    when :sha1
      self.find_by_sha1(hash)
    when :sha256
      self.find_by_sha256(hash)
    when :fuzzy_hash
      self.where(:fuzzy_hash => hash)
    when :unknown
      self.find_by_upload_file_name(hash)
    end
  end
    
  def self.hash_type(hash)
    return :md5 if hash =~ MD5_REGEX
    return :sha1 if hash =~ SHA1_REGEX
    return :sha256 if hash =~ SHA256_REGEX
    return :fuzzy_hash if hash=~ FUZZY_REGEX
    return :unknown
  end
  
  def self.find_fuzzy_matches(fuzzy_hash, lower_tolerance=70, upper_tolerance=100)
    matches = []
    Item.all.each do |item|
      percent_match = Ssdeep.fuzzy_compare(item.fuzzy_hash, fuzzy_hash)
      
      if percent_match <= upper_tolerance && percent_match >= lower_tolerance
        matches << { :item => item, :percent_match => percent_match } 
      end  
    end
    
    matches
  end
  
  def generate_hashes!
    self.generate_hashes
    self.save
  end
  
  def generate_metadata
    file = upload.queued_for_write[:original].path
    metadata = MiniExiftool.new file
    metadata_hash = metadata.to_hash
    metadata_hash.each do |k,v|
      Metadatum.create( { :name => k, :value => v, :item_id => self.id } ) unless METADATA_IGNORE_LIST.include?(k)
    end
  end
  
  def generate_hashes
    file = upload.queued_for_write[:original].path
    self.md5 = self.generate_md5(file)
    self.sha1 = self.generate_sha1(file)
    self.sha256 = self.generate_sha256(file)
    self.fuzzy_hash = self.generate_fuzzy_hash(file)
  end
  
  def generate_new_hashes
    file = upload.path
    self.md5 ||= self.generate_md5(file)
    self.sha1 ||= self.generate_sha1(file)
    self.sha256 ||= self.generate_sha256(file)
    self.fuzzy_hash ||= self.generate_fuzzy_hash(file)
  end
  
  def all_hashes_generated?
    return true if self.md5 && self.sha1 && self.sha256 && self.fuzzy_hash
    false
  end
  
  def generate_md5(file)
    Digest::MD5.file(file).hexdigest
  end
  
  def generate_sha1(file)
     Digest::SHA1.file(file).hexdigest
  end
  
  def generate_sha256(file)
    Digest::SHA256.file(file).hexdigest
  end
  
  def generate_fuzzy_hash(file)
    Ssdeep.hash_file(file).to_s
  end
  
end
