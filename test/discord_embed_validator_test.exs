defmodule DiscordEmbedValidatorTest do
  @moduledoc false
  use ExUnit.Case
  doctest DiscordEmbedValidator

  test "should return the embed when is empty" do
    embed = %{}
    sut = DiscordEmbedValidator.valid?(embed)
    assert Map.equal?(sut, embed)
  end

  test "should return the embed when valid title is provided" do
    title_embed = %{title: "valid_title"}
    sut = DiscordEmbedValidator.valid?(title_embed)
    assert Map.equal?(sut, title_embed)
  end

  test "should trigger an error when invalid title is provided" do
    {:error, _reason} = DiscordEmbedValidator.valid?(%{title: 1})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{title: :atom})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{title: %{}})
  end

  test "should trigger an error when title is must great" do
    big_title = String.duplicate("invalid_title", 400)
    {:error, _reason} = DiscordEmbedValidator.valid?(%{title: big_title})
  end

  test "should return the embed when valid description is provided" do
    valid_description = %{description: "any_description"}
    sut = DiscordEmbedValidator.valid?(valid_description)
    assert Map.equal?(sut, valid_description)
  end

  test "should trigger an error when description is must great" do
    big_description = String.duplicate("invalid_description", 1000)
    {:error, _reason} = DiscordEmbedValidator.valid?(%{title: big_description})
  end

  test "should return the embed when valid url is provided" do
    valid_url = %{url: "https://elixir-lang.org/docs.html"}
    sut = DiscordEmbedValidator.valid?(valid_url)
    assert Map.equal?(sut, valid_url)
  end

  test "should trigger an error when invalid is provided" do
    invalid_url = %{url: "invalid_url"}
    {:error, _reason} = DiscordEmbedValidator.valid?(%{url: invalid_url})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{url: 1})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{url: %{}})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{url: ""})
  end

  test "should return the embed valid timestmap is provided" do
    valid_timestamp = %{timestamp: "2015-01-23"}
    sut = DiscordEmbedValidator.valid?(valid_timestamp)
    assert Map.equal?(sut, valid_timestamp)
  end

  test "should trigger an error when timestamp is not ISO8601 timestamp" do
    invalid_timestamp = %{timestamp: "invalid_timestamp"}
    {:error, _reason} = DiscordEmbedValidator.valid?(%{timestamp: invalid_timestamp})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{timestamp: 1})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{timestamp: %{}})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{timestamp: ""})
  end

  test "should return the embed when valid color is provided" do
    valid_color = %{color: 2_423_523}
    sut = DiscordEmbedValidator.valid?(valid_color)
    assert Map.equal?(sut, valid_color)
  end

  test "should trigger an error when invalid color is provided" do
    {:error, _reason} = DiscordEmbedValidator.valid?(%{color: "invalid_color"})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{color: -1})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{color: %{}})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{color: ""})
  end
end
