# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    @stats = build_stats
    @recent_items = build_recent_items
  end

  private

  def build_stats
    {
      kunden: {
        gesamt: safe_count(WwsKunde),
        aktiv: safe_count(WwsKunde.aktiv),
        gekündigt: safe_count(WwsKunde.gekündigt)
      },
      aufträge: {
        gesamt: safe_count(WwsVerkauf),
        offen: safe_count(WwsVerkauf.offen),
        erledigt: safe_count(WwsVerkauf.erledigt)
      },
      lieferscheine: {
        gesamt: safe_count(WwsLieferschein),
        heute: safe_count(WwsLieferschein.where(datum: Date.current)),
        diese_woche: safe_count(WwsLieferschein.where(datum: 1.week.ago..Date.current))
      },
      wiegescheine: {
        gesamt: safe_count(WwsWiegeschein),
        offen: safe_count(WwsWiegeschein.offen),
        erledigt: safe_count(WwsWiegeschein.erledigt)
      }
    }
  end

  def build_recent_items
    {
      aufträge: safe_recent(WwsVerkauf, 5),
      lieferscheine: safe_recent(WwsLieferschein, 5),
      wiegescheine: safe_recent(WwsWiegeschein, 5)
    }
  end

  def safe_count(model_scope)
    model_scope.count
  rescue StandardError => e
    Rails.logger.warn "Dashboard count error: #{e.message}"
    0
  end

  def safe_recent(model_class, limit)
    return [] unless table_exists?(model_class.table_name)

    # Prüfe welche Felder verfügbar sind
    available_columns = model_class.column_names

    order_field = if available_columns.include?('datum')
                    'datum'
                  elsif available_columns.include?('created_at')
                    'created_at'
                  elsif available_columns.include?('geaendertam')
                    'geaendertam'
                  else
                    model_class.primary_key || 'id'
                  end

    model_class.order("#{order_field} DESC")
               .limit(limit)
               .includes(associations_for(model_class))
  rescue StandardError => e
    Rails.logger.warn "Dashboard recent error: #{e.message}"
    []
  end

  def table_exists?(table_name)
    ActiveRecord::Base.connection.table_exists?(table_name)
  end

  def associations_for(model_class)
    case model_class.name
    when 'WwsVerkauf'
      [:kunde]
    when 'WwsLieferschein'
      [:kunde]
    when 'WwsWiegeschein'
      [:kunde]
    else
      []
    end
  end
end