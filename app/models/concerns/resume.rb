class Resume
  include Singleton
  
  DateRange = Struct.new(:start, :duration) do
    def localized_date date
      I18n.l(date, format: :month)
    end
   
    def to_s
      localized_end = duration.nil? ? I18n.t('today') : localized_date(start + duration)
      "#{localized_date(start)} - #{localized_end}"
    end
  end

  private
  

  def self.to_date year, month, duration=nil
  end

  DATES = {
    medlinq: DateRange.new(Date.new(2013, 9)),
    th: DateRange.new(Date.new(2011, 8), 25.months),
    bfpi: DateRange.new(Date.new(2006, 12), 56.months),
    fraunhofer: DateRange.new(Date.new(2005, 3), 6.months),
    bds: DateRange.new(Date.new(2000, 9), 1.year),
    hs: DateRange.new(Date.new(2001, 9), 4.years),
    aok: DateRange.new(Date.new(1997, 9), 35.months),
    school: DateRange.new(Date.new(1984, 9), 12.years)
  }
  
  public

  def self.period company
    DATES[company.to_sym].to_s
  end

  def self.translate company, key
    I18n.t("documents.resume.#{company}.#{key}", default: '')
  end

end
