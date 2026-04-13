defmodule MailgunLoggerWeb.Plugs.AuthorizeRole do
  import Plug.Conn
  import Phoenix.Controller

  alias MailgunLogger.Roles
  alias MailgunLoggerWeb.Router.Helpers, as: Routes

  def init(roles), do: roles

  @spec call(any(), any()) :: any()
  def call(conn, allowed_roles) do
    user = conn.assigns.current_user

    allowed? =
      Enum.any?(allowed_roles, fn role ->
        Roles.is?(user, role)
      end)

    if allowed? do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to access this page.")
      |> redirect(to: Routes.event_path(conn, :index))
      |> halt()
    end
  end
end
