class MovieDecorator < Draper::Decorator
  delegate_all

  def initialize(object, options)
    super(object, options)

    @result = ExternalAPI::MovieConsumer.new.movie(object.title)
  end

  def cover
    @result[:cover]
  end

  def plot
    @result[:plot]
  end

  def rating
    @result[:rating]
  end

end
