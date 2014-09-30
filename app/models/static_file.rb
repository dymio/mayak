class StaticFile < ActiveRecord::Base

  # stored fields: :holder_id, :holder_type, :file, :filetype, :filesize

  belongs_to :holder, polymorphic: true

  mount_uploader :file, StaticFileUploader

  validates :holder, :file, presence: true

  before_save :determine_file_params

  # AtiveAdmin displayed name
  def display_name; file.file.identifier end

  def size
    self.file.file.size / 1024
  end

  private

  def determine_file_params
    self.filesize = file.file.size / 1024

    # OPTIMIZE type determination, use ruby-filemagic as example
    extname = File.extname file.path
    self.filetype = case extname
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
