defmodule Axisloot.Repo do
  use Ecto.Repo,
    otp_app: :axisloot,
    adapter: Ecto.Adapters.SQLite3
end
