require 'active_support/concern'
module AliasHasMany
  module Associations
    extend ActiveSupport::Concern

    module ClassMethods
      def direct_association(options)
        name = options.delete(:method_name)
        reflection = if options.delete(:only_one)
          ActiveRecord::Associations::Builder::HasOne.build(self, name, options, {})
        else
          ActiveRecord::Associations::Builder::HasMany.build(self, name, options, {})
        end

        ActiveRecord::Reflection.add_reflection self, name, reflection
      end

      def indirect_association(options)
        name = options.delete(:method_name)

        if options[:first_hop]
          options[:through] = options.delete(:first_hop)
        end

        if options[:second_hop]
          options[:source] = options.delete(:second_hop)
        end

        reflection = if options.delete(:only_one)
          ActiveRecord::Associations::Builder::HasOne.build(self, name, options, {})
        else
          ActiveRecord::Associations::Builder::HasMany.build(self, name, options, {})
        end

        ActiveRecord::Reflection.add_reflection self, name, reflection
      end

    end
  end
end
