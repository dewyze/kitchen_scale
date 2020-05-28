KitchenScale.build do
  si_unit :g, aliases: %i[gram grams]
  si_unit :l, aliases: %i[L liter liters litre litres]
  unit :tsp, aliases: %i[t teaspoon], system: :imperial
  # TODO
  # fl. oz US + UK
  # oz

  unit :tbsp, base: :tsp, conversion: 3, aliases: %i[T tablespoon], system: :imperial
  unit :cup, conversion: [48, :tsp], aliases: %i[c cups], system: :imperial
  unit :pint, conversion: [96, :tsp], aliases: %i[p pt pints], system: :imperial
  unit :quart, conversion: [192, :tsp], aliases: %i[qt quarts], system: :imperial
  unit :us_gal, conversion: [768, :tsp], aliases: %i[g gal gallon], system: :us, locale: :us
  unit :imp_gal, conversion: [Rational("4.54609"), :l], aliases: %i[g gal gallon], system: :imperial, locale: :uk

  generic_unit :pkg, aliases: %i[package packages packet]
  generic_unit :stick

  approx_unit :hint, conversion: [Rational("1/128"), :tsp]
  approx_unit :drop, conversion: [Rational("1/64"), :tsp]
  approx_unit :smidgen, conversion: [Rational("1/32"), :tsp]
  approx_unit :pinch, conversion: [Rational("1/16"), :tsp]
  approx_unit :dash, conversion: [Rational("1/8"), :tsp]

  ingredient :water, conversion: [[1, :ml], [1, :g]]
  ingredient :water, conversion: [[1, :tsp], [Rational("4.92892159"), :g]], locale: :us
  ingredient :water, conversion: [[1, :tsp], [5, :g]], locale: :uk
  ingredient :flour, conversion: [[1, :tsp], [Rational("2.6"), :g]], approximate: true
  ingredient :yeast, conversion: [[1, :tsp], [Rational("3.15"), :g]], approximate: true
  ingredient :yeast, conversion: [[1, :packet], [Rational("9/4"), :tsp]], approximate: true
  ingredient :butter, conversion: [[1, :stick], [24, :tsp]]
end

# KitchenScale.measure("1 g flour") => # <Measurement value: 1, unit: :g, ingredient: "flour">
# KitchenScale.measure("1 kg flour") => # <Measurement value: 1, unit: :kg, base_amount: 1000, base_unit: :g, ingredient: "flour">
# KitchenScale.measure("1 g flour").scale(2) => # <Measurement value: 2, unit: :g, ingredient: "flour">
# KitchenScale.measure("1 g flour").scale(:double) => # <Measurement value: 2, unit: :g, ingredient: "flour">
# KitchenScale.measure("1 g flour").scale("1/2") => # <Measurement value: 0.5, unit: :g, ingredient: "flour">
# KitchenScale.measure("1 g flour").scale(:half) => # <Measurement value: 0.5, unit: :g, ingredient: "flour">
# KitchenScale.measure("1 g flour").scale(:halve) => # <Measurement value: 0.5, unit: :g, ingredient: "flour">
# KitchenScale.measure("1 g flour").in("tsp") => # <Measurement value: 2.6, unit: :tsp, ingredient: "flour", approximate: true>
{
  g: {
    g: {
      mg: { conversion: Rational("1/1000") },
      cg: { conversion: Rational("1/100") },
      dg: { conversion: Rational("1/1000") },
      g: { conversion: Rational("1") },
      dag: { conversion: Rational("10") },
      hg: { conversion: Rational("100") },
      kg: { conversion: Rational("1000") },
    },
    tsp: {
      water: {
        us: Rational("1/4.9289159"),
        uk: Rational("1/5"),
      },
    },
  },
  tsp: {
    tsp: {
      tsp: { conversion: 1 },
      tbsp: { conversion: 3 },
      cup: { conversion: 48 },
      pint: { conversion: 96 },
      quart: { conversion: 192 },
      us_gal: { conversion: 768 },
    },
    g: {
      water: {
        us: { conversion: Rational("4.9289159"), approximate: true, note: "Be wary traveler!" },
        uk: { conversion: 5 },
      },
    },
    ml: {
    },
  },
}
