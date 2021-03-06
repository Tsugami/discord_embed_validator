defmodule DiscordEmbedValidatorTest do
  @moduledoc false
  use ExUnit.Case
  doctest DiscordEmbedValidator

  test "should return :ok when is empty" do
    embed = %{}
    sut = DiscordEmbedValidator.valid?(embed)
    assert sut == :ok
  end

  test "should return :ok when valid title is provided" do
    valid_title_embed = %{title: "valid_title"}
    sut = DiscordEmbedValidator.valid?(valid_title_embed)
    assert sut == :ok
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

  test "should return :ok when valid description is provided" do
    valid_description_embed = %{description: "any_description"}
    sut = DiscordEmbedValidator.valid?(valid_description_embed)
    assert sut == :ok
  end

  test "should trigger an error when description is must great" do
    big_description = String.duplicate("invalid_description", 1000)
    {:error, _reason} = DiscordEmbedValidator.valid?(%{title: big_description})
  end

  test "should return :ok when valid url is provided" do
    valid_url = %{url: "https://elixir-lang.org/docs.html"}
    sut = DiscordEmbedValidator.valid?(valid_url)
    assert sut == :ok
  end

  test "should trigger an error when invalid url is provided" do
    {:error, _reason} = DiscordEmbedValidator.valid?(%{url: "invalid_url"})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{url: 1})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{url: %{}})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{url: ""})
  end

  test "should return :ok valid timestmap is provided" do
    valid_timestamp_embed = %{timestamp: "2015-01-23"}
    sut = DiscordEmbedValidator.valid?(valid_timestamp_embed)
    assert sut == :ok
  end

  test "should trigger an error when timestamp is not ISO8601 timestamp" do
    {:error, _reason} = DiscordEmbedValidator.valid?(%{timestamp: "invalid_timestamp"})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{timestamp: 1})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{timestamp: %{}})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{timestamp: ""})
  end

  test "should return :ok when valid color is provided" do
    valid_color_embed = %{color: 2_423_523}
    sut = DiscordEmbedValidator.valid?(valid_color_embed)
    assert sut == :ok
  end

  test "should trigger an error when invalid color is provided" do
    {:error, _reason} = DiscordEmbedValidator.valid?(%{color: "invalid_color"})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{color: -1})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{color: %{}})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{color: ""})
  end

  test "should return :ok when footer has valid text" do
    footer_embed = %{footer: %{text: "valid text"}}
    sut = DiscordEmbedValidator.valid?(footer_embed)
    assert sut == :ok
  end

  test "should trigger an error when invalid footer text is provided" do
    {:error, _reason} = DiscordEmbedValidator.valid?(%{footer: %{text: 1}})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{footer: %{text: :atom}})
    {:error, _reason} = DiscordEmbedValidator.valid?(%{footer: %{text: %{}}})
  end

  test "should return :ok when footer has valid text and icon_url" do
    footer_embed = %{footer: %{text: "valid text", icon_url: "https://elixir-lang.org/docs.html"}}
    sut = DiscordEmbedValidator.valid?(footer_embed)
    assert sut == :ok
  end

  test "should trigger an error when the footer has no text but has an icon_url" do
    invalid_footer_embed = %{footer: %{icon_url: "https://elixir-lang.org/docs.html"}}
    {:error, _reason} = DiscordEmbedValidator.valid?(invalid_footer_embed)
  end
end
