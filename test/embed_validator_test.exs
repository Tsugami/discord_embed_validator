defmodule EmbedValidatorTest do
  use ExUnit.Case
  doctest EmbedValidator

  test "should return the embed when is empty" do
    embed = %{}
    sut = EmbedValidator.valid?(embed)
    assert Map.equal?(sut, embed)
  end

  test "should return the embed when valid title is provided" do
    title_embed = %{ title: "valid_title" }
    sut = EmbedValidator.valid?(title_embed)
    assert Map.equal?(sut, title_embed)
  end

  test "should trigger an error when invalid title is provided" do
    {:error, _reason} = EmbedValidator.valid?(%{ title: 1 })
    {:error, _reason} = EmbedValidator.valid?(%{ title: :atom })
    {:error, _reason} = EmbedValidator.valid?(%{ title: %{} })
  end

  test "should trigger an error when title is must great" do
    big_title = String.duplicate("invalid_title", 400)
    {:error, _reason} = EmbedValidator.valid?(%{ title: big_title })
  end

  test "should return the embed when valid description is provided" do
    valid_description = %{ description: "any_description" }
    sut = EmbedValidator.valid?(valid_description)
    assert Map.equal?(sut, valid_description)
  end

  test "should trigger an error when description is must great" do
    big_description = String.duplicate("invalid_description", 1000)
    {:error, _reason} = EmbedValidator.valid?(%{ title: big_description })
  end
end
