defmodule EmbedValidatorTest do
  use ExUnit.Case
  doctest EmbedValidator

  test "should return the embed when is empty" do
    embed = %{}
    sut = EmbedValidator.valid?(embed)
    assert Map.equal?(sut, embed)
  end

  test "should return the embed with title" do
    title_embed = %{ title: "valid_title" }
    sut = EmbedValidator.valid?(title_embed)
    assert Map.equal?(sut, title_embed)
  end

  test "should trigger an error when title is not string" do
    {:error, _reason} = EmbedValidator.valid?(%{ title: 1 })
    {:error, _reason} = EmbedValidator.valid?(%{ title: :test })
    {:error, _reason} = EmbedValidator.valid?(%{ title: %{} })
  end

  test "should trigger an error when title is must great" do
    big_title = String.duplicate("invalid_title", 400)
    {:error, _reason} = EmbedValidator.valid?(%{ title: big_title })
  end
end
