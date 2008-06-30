module ActiveRecord
  module Validations
    module ValidatesAge
      module ClassMethods
        def validates_age(*options)
          @default_configuration = {
            :field             => :date_of_birth,
            :too_old_message   => 'is too old',
            :too_young_message => 'is too young',
            :min               => 0,
            :max               => 1000000
          }
          configuration = @default_configuration.merge(options.extract_options!)
          
          if configuration[:min].nil? && configuration[:max].nil?
            raise(ArgumentError, "You must provide a min or max argument to validates_age")
          end
          
          validates_each configuration[:field] do |record, attr, value|
            next if value.nil?
            
            age = Date.today.year - value.year
            record.errors.add attr, configuration[:too_old_message]   if age > configuration[:max]
            record.errors.add attr, configuration[:too_young_message] if age < configuration[:min]
          end
        end
      end

      def self.included(receiver)
        receiver.extend ClassMethods
      end
    end
  end
end