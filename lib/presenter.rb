class Presenter < SimpleDelegator
  def initialize model, view=nil
    @view = view
    super(model)
  end

  def context view
    @view = view
    self
  end

  private
  def h
    @view
  end

  def model
    __getobj__
  end
end
