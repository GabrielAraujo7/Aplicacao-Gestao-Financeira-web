defmodule ProjectDeltaWeb.ReceitaHTML do
  use ProjectDeltaWeb, :html

  embed_templates "receita_html/*"

  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def receita_form(assigns)
end
