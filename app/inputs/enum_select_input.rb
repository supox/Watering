class EnumSelectInput < FormtasticBootstrap::Inputs::SelectInput
  def collection
    enum = object.send(method)
    enum.class.select_options
  end

  def input_options
    enum = object.send(method)
    options[:selected] = enum.to_s
    options[:include_blank] = enum.allow_blank

    super()
  end
end
