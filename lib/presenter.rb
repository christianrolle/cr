class Presenter < SimpleDelegator
  def initialize model, view
    @view = view
    super(model)
  end

  private
  def h
    @view
  end

  def model
    __getobj__
  end
end
