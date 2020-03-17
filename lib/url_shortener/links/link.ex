defmodule UrlShortener.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :url, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url])
    |> put_change(:slug, generate_slug())
    |> validate_required([:url, :slug])
    |> validate_format(:url, ~r/^https?:\/\/|^www./)
    |> unique_constraint(:url)
    |> unique_constraint(:slug)
  end

  def generate_slug do
    :crypto.strong_rand_bytes(8)
    |> Base.url_encode64
    |> binary_part(0, 8)
  end
end
