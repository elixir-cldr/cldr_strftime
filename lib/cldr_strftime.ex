defmodule Cldr.Strftime do

  @doc false
  def cldr_backend_provider(config) do
    Cldr.Strftime.Backend.define_backend_modules(config)
  end

end
