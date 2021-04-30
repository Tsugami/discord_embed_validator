defmodule EmbedValidatorTest do
  use ExUnit.Case
  doctest EmbedValidator

  test "greets the world" do
    assert EmbedValidator.hello() == :world
  end
end
