module KitchenScale
  class Unit
    include Comparable

    attr_reader :name,
                :base,
                :conversion,
                :aliases,
                :system,
                :locale,
                :approximate,
                :ingredient_unit,
                :names,
                :inverse_conversion

    def initialize(name, options = {})
      if options[:conversion] && !options[:base]
        raise KitchenScale::MissingBaseUnitError, "cannot have conversion without base unit"
      end

      @name = name.freeze
      @base = options[:base] ? options[:base].freeze : @name
      @conversion = options[:conversion] ? Rational(options[:conversion]) : Rational(1)
      @aliases = options[:aliases] ? options[:aliases].map(&:freeze) : []
      @system = options[:system].freeze
      @locale = options[:locale].freeze
      @approximate = options[:approximate]
      @ingredient_unit = options[:ingredient_unit]
      # @ambiuous_aliases = options[:ambiuous_aliases] || []

      @names = ([@name] + @aliases).map(&:freeze)
      @inverse_conversion = 1 / @conversion if @conversion
    end

    def <=>(other)
      raise MismatchedUnitError unless @base == other.base

      @conversion <=> other.conversion
    end
  end
end
