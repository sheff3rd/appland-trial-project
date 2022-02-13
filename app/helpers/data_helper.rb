module DataHelper
  attr_reader :events

  def self.parse(events)
    @events = events

    parsed_hash
  end

  def self.parsed_hash
    @parsed_hash ||= @events.filter { |event| event_present?(event) && ruby_file?(event) && belongs_to_app?(event) }
  end

  private

  def event_present?(event)
    event[:path].present?
  end

  def ruby_file?(event)
    event[:path].ends_with?(".rb")
  end

  def belongs_to_app?(event)
    event[:path].starts_with?("app/")
  end
end
