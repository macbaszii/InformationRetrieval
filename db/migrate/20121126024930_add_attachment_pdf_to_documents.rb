class AddAttachmentPdfToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.has_attached_file :pdf
    end
  end

  def self.down
    drop_attached_file :documents, :pdf
  end
end
