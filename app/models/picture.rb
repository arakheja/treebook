class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  attr_accessible :caption, :description, :asset

  #unknown attribute asset is fixed with
  has_attached_file :asset, styles: {
    large: "800x800>", medium: "300x200>", small: "260x180>", thumb: "80x80#"
  }
  validates_attachment_content_type :asset, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :asset, attachment_presence: true

  def to_s
  	caption? ? caption : "Current Picture"
  end


end
