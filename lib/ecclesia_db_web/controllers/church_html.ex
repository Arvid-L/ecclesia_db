defmodule EcclesiaDbWeb.ChurchHTML do
  use EcclesiaDbWeb, :html

  embed_templates "church_html/*"

  @doc """
  Renders a church form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def church_form(assigns)
end
