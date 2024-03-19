class UploadJob
  include Sidekiq::Job

  def perform
    # Do something
    publisher = Publisher.new
    publisher.publish('','','')
  end
end
