RSpec.describe KitchenScale::Unit do
  subject(:unit) { described_class.new(name, options) }

  let(:name) { :tbsp }
  let(:base) { :tsp }
  let(:conversion) { 3 }
  let(:aliases) { %i[T tablespoon Tablespoon] }
  let(:system) { :imperial }
  let(:locale) { :us }
  let(:approximate) { false }
  let(:ingredient_unit) { false }
  let(:options) do
    {
      base: base,
      conversion: conversion,
      aliases: aliases,
      system: system,
      locale: locale,
      approximate: approximate,
      ingredient_unit: ingredient_unit,
    }
  end

  describe ".new" do
    let(:approximate) { true }
    let(:ingredient_unit) { true }

    it "throws an error if conversion is present without base" do
      expect do
        described_class.new(:tbsp, conversion: 10)
      end.to raise_exception(KitchenScale::MissingBaseUnitError, "cannot have conversion without base unit")
    end

    it "sets the readable attributes" do
      expect(unit.name).to eq(name)
      expect(unit.base).to eq(base)
      expect(unit.conversion).to eq(conversion)
      expect(unit.conversion).to be_a(Rational)
      expect(unit.aliases).to match_array(aliases)
      expect(unit.system).to eq(system)
      expect(unit.locale).to eq(locale)
      expect(unit.approximate).to be true
      expect(unit.ingredient_unit).to be true

      expect(unit.names).to match_array([name] + aliases)
      expect(unit.inverse_conversion).to eq(1 / Rational(conversion))
    end

    context "with defaults" do
      it "sets the conversion to 1" do
        unit = described_class.new(name)

        expect(unit.name).to eq(name)
        expect(unit.base).to eq(name)
        expect(unit.conversion).to eq(1)
        expect(unit.conversion).to be_a(Rational)
        expect(unit.aliases).to eq([])
        expect(unit.system).to be_nil
        expect(unit.locale).to be_nil
        expect(unit.approximate).to be_nil

        expect(unit.names).to match_array([name])
        expect(unit.inverse_conversion).to eq(1)
      end
    end
  end

  describe "Comparable" do
    it "is greater than if the conversion is greater" do
      cup_unit = described_class.new(:cup, base: :tsp, conversion: 48)

      expect(cup_unit).to be > unit
    end

    it "is less than if the conversion is lesser" do
      tsp_unit = described_class.new(:tsp, base: :tsp)

      expect(tsp_unit).to be < unit
    end

    it "is equal if the conversions are equal" do
      tbsp_unit = described_class.new(:tbsp, base: :tsp, conversion: 3)

      expect(tbsp_unit).to eq(unit)
    end

    it "raises an error if they are not the same base unit" do
      g_unit = described_class.new(:kg, base: :g, conversion: 1000)

      expect do
        unit > g_unit
      end.to raise_exception(KitchenScale::MismatchedUnitError)
    end
  end
end
