class Image < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :user
  belongs_to :text

  after_post_process :hocr

  private
    def hocr
      system("hocr -i #{photo.queued_for_write[:original].path} -o /tmp/ocresult")
      file = File.open("/tmp/ocresult", "rb")
      contents = file.read
      photo.instance.text.content = contents
      photo.instance.text.save()
      File.delete(file)
    end

end
