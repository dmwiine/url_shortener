defmodule UrlShortenerWeb.LinkView do
  use UrlShortenerWeb, :view

  def shorten_url(url) do
    if String.length(url) > 40 do
      String.split_at(url, 40)
      |> elem(0)
      |> String.pad_trailing(43, ".")
    else
      url
    end
  end
end
