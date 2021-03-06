require 'lims-api/core_resource'
require 'lims-api/struct_stream'

module Lims::ManagementApp
  class Sample
    class SampleResource < Lims::Api::CoreResource

      def content_to_stream(s, mime_type)
        object.attributes.each do |k,v|
          next if ["dna", "rna", "cellular_material", "genotyping"].include?(k.to_s)
          s.add_key k
          s.add_value v
        end

        component_to_stream("dna", object.dna, s, mime_type)
        component_to_stream("rna", object.rna, s, mime_type)
        component_to_stream("cellular_material", object.cellular_material, s, mime_type)
        component_to_stream("genotyping", object.genotyping, s, mime_type)
      end

      private

      def component_to_stream(key, object, s, mime_type)
        if object
          s.add_key key
          hash_to_stream(s, object.attributes, mime_type)
        end
      end
    end 
  end
end
