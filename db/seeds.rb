# db/seeds.rb

# Hilfsmethode um nur verfügbare Attribute zu verwenden
def safe_attributes(model_class, attributes)
  available_columns = model_class.column_names.map(&:to_sym)
  attributes.select { |key, _| available_columns.include?(key) }
end

puts "🌱 WWS Seed Daten werden erstellt..."

# Nur in Development löschen, und nur wenn Tabellen existieren
if Rails.env.development?
  puts "⚠️  Lösche bestehende Daten..."

  # Prüfen ob Tabellen existieren, bevor wir löschen
  tables = ActiveRecord::Base.connection.tables

  WwsWiegeschein.delete_all if tables.include?('wws_wiegeschein1')
  WwsLieferscheinPosition.delete_all if tables.include?('wws_vliefer2')
  WwsLieferschein.delete_all if tables.include?('wws_vliefer1')
  WwsVerkaufPosition.delete_all if tables.include?('wws_verkauf2')
  WwsVerkauf.delete_all if tables.include?('wws_verkauf1')
  WwsKunde.delete_all if tables.include?('wws_kunden1')
  Adresse.delete_all if tables.include?('adressen')
end

# 1. ADRESSEN erstellen
puts "📍 Erstelle Adressen..."

adressen = [
  {
    nummer: 1001,
    name1: "Müller Agrar GmbH",
    name2: "Getreidehandel",
    branche: "Landwirtschaft",
    strasse: "Hauptstraße 15",
    nat: "D",
    plz: "94436",
    ort: "Simbach",
    land: "Deutschland",
    telefon1: "08571/12345",
    telefon2: "08571/12346",
    telefax: "08571/12347",
    email: "info@mueller-agrar.de",
    homepage: "www.mueller-agrar.de",
    art: "K"
  },
  {
    nummer: 1002,
    name1: "Bauer Schmidt",
    name2: "Milchviehbetrieb",
    branche: "Milchwirtschaft",
    strasse: "Dorfstraße 8",
    nat: "D",
    plz: "84347",
    ort: "Pfarrkirchen",
    land: "Deutschland",
    telefon1: "08561/98765",
    email: "schmidt@milchbauer.de",
    art: "K"
  },
  {
    nummer: 1003,
    name1: "Genossenschaft Rottal eG",
    name2: "Waren- und Dienstleistungen",
    branche: "Genossenschaft",
    strasse: "Genossenschaftsweg 1",
    nat: "D",
    plz: "84307",
    ort: "Eggenfelden",
    land: "Deutschland",
    telefon1: "08721/55555",
    telefon2: "08721/55556",
    telefax: "08721/55557",
    email: "kontakt@rottal-eg.de",
    homepage: "www.rottal-eg.de",
    art: "K"
  },
  {
    nummer: 1004,
    name1: "Futtermittel Weber GmbH",
    name2: "Großhandel",
    branche: "Futtermittelhandel",
    strasse: "Industriestraße 12",
    nat: "D",
    plz: "94474",
    ort: "Vilshofen",
    land: "Deutschland",
    telefon1: "08541/77777",
    email: "weber@futtermittel.de",
    art: "L"
  },
  {
    nummer: 1005,
    name1: "Spedition Huber",
    name2: "Logistik & Transport",
    branche: "Spedition",
    strasse: "Logistikpark 5",
    nat: "D",
    plz: "94032",
    ort: "Passau",
    land: "Deutschland",
    telefon1: "0851/123456",
    email: "huber@spedition.de",
    art: "S"
  }
]

adressen.each do |adresse_data|
  safe_data = safe_attributes(Adresse, adresse_data)
  Adresse.create!(safe_data)
end

puts "✅ #{Adresse.count} Adressen erstellt"

# 2. KUNDEN erstellen
puts "👥 Erstelle Kunden..."

kunden = [
  {
    kundennr: 10001,
    kundgruppe: 1,
    bundesland: 9, # Bayern
    umsatzsteuer: "J",
    gekuendigt: "N",
    mitgliednr: 12345,
    datumeintritt: 1.year.ago,
    bonusberecht: "J",
    rabatt: 2.5,
    zahlungart: "1",
    geaendertam: Time.current
  },
  {
    kundennr: 10002,
    kundgruppe: 2,
    bundesland: 9,
    umsatzsteuer: "J",
    gekuendigt: "N",
    mitgliednr: 12346,
    datumeintritt: 2.years.ago,
    bonusberecht: "N",
    rabatt: 1.5,
    zahlungart: "2",
    geaendertam: Time.current
  },
  {
    kundennr: 10003,
    kundgruppe: 1,
    bundesland: 9,
    umsatzsteuer: "J",
    gekuendigt: "N",
    mitgliednr: 12347,
    datumeintritt: 3.years.ago,
    bonusberecht: "J",
    rabatt: 3.0,
    zahlungart: "1",
    geaendertam: Time.current
  }
]

kunden.each do |kunde_data|
  safe_data = safe_attributes(WwsKunde, kunde_data)
  WwsKunde.create!(safe_data)
end

puts "✅ #{WwsKunde.count} Kunden erstellt"

# 3. VERKAUFSAUFTRÄGE erstellen
puts "📝 Erstelle Verkaufsaufträge..."

aufträge = [
  {
    vauftragnr: 100001,
    datum: 1.week.ago,
    bediener: "MEIER",
    vertreter: "VT001",
    kundennr: 10001,
    kundadrnr: 1001,
    rechnadrnr: 1001,
    liefadrnr: 1001,
    kundname: "Müller Agrar GmbH",
    bestdatum: 1.week.ago,
    bestnrkd: "BEST-2024-001",
    auftstatus: "B",
    erledigt: "N",
    waehrcode: 1,
    mwstkz: 1,
    skonto1tg: 10,
    skonto1pr: 2.0,
    skonto2tg: 20,
    skonto2pr: 1.0,
    nettotg: 30,
    zahlbedtext: "2% Skonto bei Zahlung binnen 10 Tagen",
    lager: 1,
    geplliefdatum: 1.day.from_now,
    geaendertam: Time.current
  },
  {
    vauftragnr: 100002,
    datum: 3.days.ago,
    bediener: "WEBER",
    vertreter: "VT002",
    kundennr: 10002,
    kundadrnr: 1002,
    rechnadrnr: 1002,
    liefadrnr: 1002,
    kundname: "Bauer Schmidt",
    bestdatum: 3.days.ago,
    bestnrkd: "BEST-2024-002",
    auftstatus: "B",
    erledigt: "N",
    waehrcode: 1,
    mwstkz: 1,
    skonto1tg: 7,
    skonto1pr: 2.0,
    nettotg: 14,
    zahlbedtext: "2% Skonto bei Zahlung binnen 7 Tagen",
    lager: 1,
    geplliefdatum: 2.days.from_now,
    geaendertam: Time.current
  },
  {
    vauftragnr: 100003,
    datum: 2.weeks.ago,
    bediener: "HUBER",
    vertreter: "VT001",
    kundennr: 10003,
    kundadrnr: 1003,
    rechnadrnr: 1003,
    liefadrnr: 1003,
    kundname: "Genossenschaft Rottal eG",
    bestdatum: 2.weeks.ago,
    bestnrkd: "BEST-2024-003",
    auftstatus: "E",
    erledigt: "J",
    waehrcode: 1,
    mwstkz: 1,
    skonto1tg: 10,
    skonto1pr: 2.0,
    skonto2tg: 20,
    skonto2pr: 1.0,
    nettotg: 30,
    zahlbedtext: "2% Skonto bei Zahlung binnen 10 Tagen",
    lager: 1,
    geplliefdatum: 1.week.ago,
    geaendertam: Time.current
  }
]

aufträge.each do |auftrag_data|
  safe_data = safe_attributes(WwsVerkauf, auftrag_data)
  WwsVerkauf.create!(safe_data)
end

puts "✅ #{WwsVerkauf.count} Verkaufsaufträge erstellt"

# 4. VERKAUFS-POSITIONEN erstellen
puts "📋 Erstelle Verkaufs-Positionen..."

positionen = [
  # Auftrag 100001 Positionen
  {
    vauftragnr: 100001,
    posnr: 10,
    posart: "N",
    artikelnr: "WEIZEN001",
    bezeichn1: "Weizen Futterweizen",
    bezeichn2: "Qualität A, 13% Protein",
    menge: 25000.0,
    einheit: "kg",
    einhpreis: 0.28,
    listpreis: 0.30,
    rabatt: 5.0,
    mwstsatz: 19.0,
    netto: 6650.0,
    mwst: 1263.5,
    brutto: 7913.5,
    lager: 1,
    abteilung: 1,
    gewicht: 1.0
  },
  {
    vauftragnr: 100001,
    posnr: 20,
    posart: "N",
    artikelnr: "GERSTE001",
    bezeichn1: "Gerste Braugerste",
    bezeichn2: "2-zeilig, Sorte Scarlett",
    menge: 15000.0,
    einheit: "kg",
    einhpreis: 0.32,
    listpreis: 0.35,
    rabatt: 8.0,
    mwstsatz: 19.0,
    netto: 4416.0,
    mwst: 839.04,
    brutto: 5255.04,
    lager: 1,
    abteilung: 2,
    gewicht: 1.0
  },
  # Auftrag 100002 Positionen
  {
    vauftragnr: 100002,
    posnr: 10,
    posart: "N",
    artikelnr: "FUTTER001",
    bezeichn1: "Kraftfutter Milchvieh",
    bezeichn2: "18% Protein, pelletiert",
    menge: 5000.0,
    einheit: "kg",
    einhpreis: 0.45,
    listpreis: 0.48,
    rabatt: 6.0,
    mwstsatz: 7.0,
    netto: 2115.0,
    mwst: 148.05,
    brutto: 2263.05,
    lager: 2,
    abteilung: 3,
    gewicht: 1.0
  },
  # Auftrag 100003 Positionen (bereits erledigt)
  {
    vauftragnr: 100003,
    posnr: 10,
    posart: "N",
    artikelnr: "MAIS001",
    bezeichn1: "Körnermais",
    bezeichn2: "Feuchtigkeit 14%",
    menge: 20000.0,
    einheit: "kg",
    einhpreis: 0.26,
    listpreis: 0.28,
    rabatt: 7.0,
    mwstsatz: 19.0,
    netto: 4836.0,
    mwst: 918.84,
    brutto: 5754.84,
    lager: 1,
    abteilung: 1,
    gewicht: 1.0
  }
]

positionen.each do |position_data|
  safe_data = safe_attributes(WwsVerkaufPosition, position_data)
  WwsVerkaufPosition.create!(safe_data)
end

puts "✅ #{WwsVerkaufPosition.count} Verkaufs-Positionen erstellt"

# 5. LIEFERSCHEINE erstellen
puts "🚚 Erstelle Lieferscheine..."

lieferscheine = [
  {
    liefschnr: 200001,
    vauftragnr: 100003,
    datum: 1.week.ago,
    bediener: "HUBER",
    vertreter: "VT001",
    kundennr: 10003,
    kundadrnr: 1003,
    rechnadrnr: 1003,
    liefadrnr: 1003,
    kundname: "Genossenschaft Rottal eG",
    selbstabholung: "N",
    gedruckt: "J",
    lager: 1,
    spediteurnr: 5001,
    fahrzeug: "AB-CD 1234",
    ladedatum: 1.week.ago,
    uhrzeit: "08:30"
  },
  {
    liefschnr: 200002,
    vauftragnr: 100001,
    datum: 2.days.ago,
    bediener: "MEIER",
    vertreter: "VT001",
    kundennr: 10001,
    kundadrnr: 1001,
    rechnadrnr: 1001,
    liefadrnr: 1001,
    kundname: "Müller Agrar GmbH",
    selbstabholung: "J",
    gedruckt: "J",
    lager: 1,
    ladedatum: 2.days.ago,
    uhrzeit: "14:15"
  }
]

lieferscheine.each do |lieferschein_data|
  safe_data = safe_attributes(WwsLieferschein, lieferschein_data)
  WwsLieferschein.create!(safe_data)
end

puts "✅ #{WwsLieferschein.count} Lieferscheine erstellt"

# 6. LIEFERSCHEIN-POSITIONEN erstellen
puts "📦 Erstelle Lieferschein-Positionen..."

lieferpositionen = [
  # Lieferschein 200001 (Auftrag 100003)
  {
    liefschnr: 200001,
    posnr: 10,
    vauftragnr: 100003,
    vauftragposnr: 10,
    artikelnr: "MAIS001",
    bezeichn1: "Körnermais",
    bezeichn2: "Feuchtigkeit 14%",
    liefmenge: 20000.0,
    einheit: "kg",
    einhpreis: 0.26,
    rabatt: 7.0,
    mwstsatz: 19.0,
    netto: 4836.0,
    mwst: 918.84,
    brutto: 5754.84,
    gewicht: 1.0,
    lager: 1,
    abteilung: 1,
    chargennr: 2024001
  },
  # Lieferschein 200002 (Auftrag 100001) - Teillieferung
  {
    liefschnr: 200002,
    posnr: 10,
    vauftragnr: 100001,
    vauftragposnr: 10,
    artikelnr: "WEIZEN001",
    bezeichn1: "Weizen Futterweizen",
    bezeichn2: "Qualität A, 13% Protein",
    liefmenge: 12500.0,  # Nur die Hälfte geliefert
    einheit: "kg",
    einhpreis: 0.28,
    rabatt: 5.0,
    mwstsatz: 19.0,
    netto: 3325.0,
    mwst: 631.75,
    brutto: 3956.75,
    gewicht: 1.0,
    lager: 1,
    abteilung: 1,
    chargennr: 2024002
  }
]

lieferpositionen.each do |position_data|
  safe_data = safe_attributes(WwsLieferscheinPosition, position_data)
  WwsLieferscheinPosition.create!(safe_data)
end

puts "✅ #{WwsLieferscheinPosition.count} Lieferschein-Positionen erstellt"

# 7. WIEGESCHEINE erstellen
puts "⚖️ Erstelle Wiegescheine..."

wiegescheine = [
  {
    id: 1,
    dbid: 1,
    wiegescheinnr: 300001,
    datum: 1.week.ago,
    uhrzeit: "08:45",
    bediener: "WAG1",  # Verkürzt von "WAAGE1"
    kundliefnr: 10003,
    artikelnr: "MAIS001",
    bezeichn1: "Körnermais",
    bezeichn2: "Feuchtigkeit 14%",
    kfz_kennzeichen: "AB-CD 1234",
    wiegungdatum1: 1.week.ago.change(hour: 8, min: 30),
    wiegungdatum2: 1.week.ago.change(hour: 9, min: 15),
    wiegunguhrzeit1: "08:30",
    wiegunguhrzeit2: "09:15",
    wiegungnetto1: 18500.0,  # Leergewicht
    wiegungnetto2: 38750.0,  # Vollgewicht
    gewicht: 20250.0,        # Nettogewicht
    preis: 0.26,
    menge: 20250.0,
    erledigt: "J",
    status: 1,
    lager: 1,
    abteilung: 1,
    chargennr: 2024001,
    auftragnr: 100003,
    liefliefschnr: "200001",
    liefadrnr: 1003,
    geaendertam: Time.current
  },
  {
    id: 2,
    dbid: 1,
    wiegescheinnr: 300002,
    datum: 2.days.ago,
    uhrzeit: "14:30",
    bediener: "WAG1",  # Verkürzt
    kundliefnr: 10001,
    artikelnr: "WEIZEN001",
    bezeichn1: "Weizen Futterweizen",
    bezeichn2: "Qualität A, 13% Protein",
    kfz_kennzeichen: "EF-GH 5678",
    wiegungdatum1: 2.days.ago.change(hour: 14, min: 15),
    wiegungdatum2: 2.days.ago.change(hour: 14, min: 45),
    wiegunguhrzeit1: "14:15",
    wiegunguhrzeit2: "14:45",
    wiegungnetto1: 16800.0,  # Leergewicht
    wiegungnetto2: 29380.0,  # Vollgewicht
    gewicht: 12580.0,        # Nettogewicht
    preis: 0.28,
    menge: 12580.0,
    erledigt: "J",
    status: 1,
    lager: 1,
    abteilung: 1,
    chargennr: 2024002,
    auftragnr: 100001,
    liefliefschnr: "200002",
    liefadrnr: 1001,
    geaendertam: Time.current
  },
  {
    id: 3,
    dbid: 1,
    wiegescheinnr: 300003,
    datum: Date.current,
    uhrzeit: "10:15",
    bediener: "WAG2",  # Verkürzt
    kundliefnr: 10002,
    artikelnr: "FUTTER001",
    bezeichn1: "Kraftfutter Milchvieh",
    bezeichn2: "18% Protein, pelletiert",
    kfz_kennzeichen: "IJ-KL 9012",
    wiegungdatum1: Date.current.beginning_of_day + 10.hours,
    wiegungnetto1: 12200.0,  # Nur erste Wiegung
    gewicht: nil,            # Noch nicht fertig gewogen
    preis: 0.45,
    erledigt: "N",
    status: 0,
    lager: 2,
    abteilung: 3,
    auftragnr: 100002,
    liefadrnr: 1002,
    geaendertam: Time.current
  }
]

wiegescheine.each do |wiegeschein_data|
  safe_data = safe_attributes(WwsWiegeschein, wiegeschein_data)
  WwsWiegeschein.create!(safe_data)
end

puts "✅ #{WwsWiegeschein.count} Wiegescheine erstellt"

# Zusammenfassung
puts "\n🎉 Seed-Daten erfolgreich erstellt!"
puts "=" * 50

counts = []
counts << "📍 Adressen: #{Adresse.count}" if ActiveRecord::Base.connection.table_exists?('adressen')
counts << "👥 Kunden: #{WwsKunde.count}" if ActiveRecord::Base.connection.table_exists?('wws_kunden')
counts << "📝 Verkaufsaufträge: #{WwsVerkauf.count}" if ActiveRecord::Base.connection.table_exists?('wws_verkauf1')
counts << "📋 Verkaufs-Positionen: #{WwsVerkaufPosition.count}" if ActiveRecord::Base.connection.table_exists?('wws_verkauf2')
counts << "🚚 Lieferscheine: #{WwsLieferschein.count}" if ActiveRecord::Base.connection.table_exists?('wws_vliefer1')
counts << "📦 Lieferschein-Positionen: #{WwsLieferscheinPosition.count}" if ActiveRecord::Base.connection.table_exists?('wws_vliefer2')
counts << "⚖️ Wiegescheine: #{WwsWiegeschein.count}" if ActiveRecord::Base.connection.table_exists?('wws_wiegeschein')

counts.each { |count| puts count }
puts "=" * 50

# Beispiel-Abfragen demonstrieren
puts "\n🔍 Beispiel-Abfragen:"
puts "Aktive Kunden: #{WwsKunde.aktiv.count}" if ActiveRecord::Base.connection.table_exists?('wws_kunden')
puts "Offene Aufträge: #{WwsVerkauf.offen.count}" if ActiveRecord::Base.connection.table_exists?('wws_verkauf1')
puts "Erledigte Wiegescheine: #{WwsWiegeschein.erledigt.count}" if ActiveRecord::Base.connection.table_exists?('wws_wiegeschein')

# Geschäftsdaten-Übersicht
if ActiveRecord::Base.connection.table_exists?('wws_verkauf1') && ActiveRecord::Base.connection.table_exists?('wws_verkauf2')
  begin
    gesamtumsatz = WwsVerkauf.joins(:positionen).sum('wws_verkauf2.brutto')
    puts "Gesamtumsatz Aufträge: #{gesamtumsatz.round(2)} €"
  rescue => e
    puts "Gesamtumsatz konnte nicht berechnet werden: #{e.message}"
  end
end

puts "\n✨ Seeds abgeschlossen!"