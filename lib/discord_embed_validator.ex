defmodule DiscordEmbedValidator do
  alias Skooma.Validators
  alias DiscordEmbedValidator.Utils

  @url_schema [:string, :not_required, &Utils.is_url/1]

  @moduledoc """
  Documentation for `DiscordEmbedValidator`.
  """

  @doc """
  Valid an Embed

  ## Examples

      iex> DiscordEmbedValidator.valid?(%{description: "my embed description", title: "my embed title"})
      :ok
  """

  def valid?(embed) do
    cond do
      is_struct(embed) ->
        embed
        |> Map.from_struct
        |> valid?
      is_map(embed) ->
        validate(embed)
    end
  end

  defp validate(embed) do
    schema = %{
      title: [:string, :not_required, heading_length_validator()],
      description: [:string, :not_required, text_length_validator()],
      url: @url_schema,
      timestamp: [:string, :not_required, &timestamp_validator/1],
      color: [:number, :not_required, &color_validator/1],
      fields: [:list, :map, :not_required, &field_schema/0],
      footer: [:map, :not_required, &footer_schema/0],
      image: [:map, :not_required, &proxy_schema/0],
      thumbnail: [:map, :not_required, &proxy_schema/0],
      video: [:map, :not_required, &proxy_schema/0],
      provider: [:map, :not_required, &provider_schema/0],
      author: [:map, :not_required, &author_schema/0],
    }

    case Skooma.valid?(embed, schema) do
      :ok -> total_length_validator(embed)
      {:error, reason} -> {:error, reason}
    end
  end

  defp field_schema do
    %{
      name: [:string, heading_length_validator()],
      value: [:string, text_length_validator()],
      inline: [:bool, :not_required]
    }
  end

  defp footer_schema do
    %{
      text: :string,
      icon_url: @url_schema,
      proxy_icon_url: @url_schema
    }
  end

  defp proxy_schema do
    %{
      url: @url_schema,
      name: [:string, :not_required],
      icon_url: [:string, :not_required],
      proxy_icon_url: [:string, :not_required]
    }
  end

  defp provider_schema do
    %{
      url: @url_schema,
      name: [:string, :not_required]
    }
  end

  defp author_schema do
    %{
      url: @url_schema,
      name: [:string, :not_required, heading_length_validator()],
      icon_url: [:string, :not_required],
      proxy_icon_url: [:string, :not_required]
    }
  end

  defp heading_length_validator, do: Validators.max_length(256)

  defp text_length_validator, do: Validators.max_length(1024)

  defp total_length_validator(embed) do
    fields = Map.get(embed, :fields, [])
    fields_length = Enum.reduce(fields, 0, fn field, acc ->
      name = Utils.fetch_value_length(field, :name)
      value = Utils.fetch_value_length(field, :value)

      acc + name + value
    end)

    total = Enum.sum([
      fields_length,
      Utils.fetch_value_length(embed, :title),
      Utils.fetch_value_length(embed, :description),
      Utils.fetch_value_length(embed, [:footer, :text]),
      Utils.fetch_value_length(embed, [:author, :name]),
    ])

    if total > 6000 do
      {:error, "the characters in all title, description, field.name, field.value, footer.text, and author.name fields must not exceed 6000 characters in total"}
    else
      :ok
    end
  end

  defp color_validator (val) do
    if Utils.is_color(val) do
      :ok
    else
      {:error, "color is invalid!"}
    end
  end

  defp timestamp_validator (val) do
    if Utils.is_iso8601(val) do
      :ok
    else
      {:error, "timestamp invalid, timestamp should to be ISO8601 Timestamp"}
    end
  end
end
