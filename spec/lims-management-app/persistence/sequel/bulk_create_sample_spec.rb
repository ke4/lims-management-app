require 'lims-management-app/persistence/sequel/spec_helper'
require 'lims-management-app/sample/bulk_create_sample'
require 'lims-management-app/sample/sample_shared'
require 'lims-management-app/spec_helper'
require 'integrations/spec_helper'

module Lims::ManagementApp
  describe Sample::BulkCreateSample do
    include_context "sample factory"
    include_context "for application", "bulk create"
    include_context "sequel store"

    shared_examples_for "sequel bulk creating samples" do
      context "common samples" do
        it_behaves_like "changing the table", :samples, 3
      end

      context "samples with dna" do
        it_behaves_like "changing the table", :samples, 3
        it_behaves_like "changing the table", :dna, 3
      end

      context "samples with dna, rna and cellular material" do
        it_behaves_like "changing the table", :samples, 3
        it_behaves_like "changing the table", :dna, 3
        it_behaves_like "changing the table", :rna, 3
        it_behaves_like "changing the table", :cellular_material, 3
      end
    end

    context "samples bulk creation" do
      let(:quantity) { 3 }

      subject {
        described_class.new(:store => store, :user => user, :application => application) do |a,s|
          full_sample_parameters.each do |k,v|
            a.send("#{k}=", v)
          end
          a.quantity = quantity
        end
      }

      it_behaves_like "sequel bulk creating samples"
    end
  end
end
