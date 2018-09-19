module AliasHasMany
  class Railtie < ::Rails::Railtie

    initializer 'alias_has_many.active_record' do
      ActiveSupport.on_load(:active_record) do
        include AliasHasMany::Associations
      end
    end
  end
end
