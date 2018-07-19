class ExportJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, file_path)
    user = User.find(user_id)
    MovieExporter.new.call(user, file_path)
  end
end