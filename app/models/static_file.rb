class StaticFile < ActiveRecord::Base

  belongs_to :holder, polymorphic: true

  mount_uploader :file, StaticFileUploader

  validates :file, presence: true

  before_save :determine_file_params

  scope :holderless, -> { where(holder: nil) }

  def image?
    file.image?
  end

  private

  def determine_file_params
    self.name = file.file.identifier

    self.size = file.file.size / 1024

    # OPTIMIZE type determination, use ruby-filemagic as example
    extname = File.extname(file.path).downcase
    self.filetype =
      case extname
      when '.txt'
       'txt'
      when '.pdf'
       'pdf'
      when '.doc', '.dot', '.docx', '.docm', '.dotx', '.dotm', '.rtf'
       'doc'
      when '.xls', '.xlt', '.xlm', '.xlsx', '.xlsm', '.xltx', '.xltm', '.xlsb', '.xlam'
       'xls'
      when '.ppt', '.pot', '.pps', '.pptx', '.pptm', '.potx', '.potm', '.ppam', '.ppsx', '.ppsm', '.sldx', '.sldm', '.thmx'
       'ppt'
      when '.odt', '.ott', '.sxw', '.stw', '.sdw', '.uot', '.uof'
       'odt'
      when '.zip', '.zipx', '.rar', '.tar', '.gz', '.tar.gz', '.bz2', '.tar.bz2', '.7z'
       'zip'
      when '.xml', '.html', '.htm', '.xhtml'
       'xml'
      when '.css', '.scss', '.sass', '.less', '.js', '.coffee', '.json'
       'css'
      when '.jpg', '.jpeg', '.png', '.gif', '.bmp'
       'img'
      else
       'non'
      end
  end

end
