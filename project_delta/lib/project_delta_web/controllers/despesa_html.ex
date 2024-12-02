defmodule ProjectDeltaWeb.DespesaHTML do
  use ProjectDeltaWeb, :html

  embed_templates "despesa_html/*"

  @doc """
  Renders a despesa form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def despesa_form(assigns)
end
