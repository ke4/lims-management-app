require "integrations/requests/apiary/11_sample_resource/spec_helper"
describe "bulk_update_sample_with_sanger_sample_id_by_uuid", :sample => true do
  include_context "use core context service"
  include_context "timecop"
  it "bulk_update_sample_with_sanger_sample_id_by_uuid" do
    sample = Lims::ManagementApp::Sample.new({
        "sanger_sample_id" => "S2-1",
        "gender" => "Male",
        "state" => "draft",
        "disease_phenotype" => "normal",
        "age_band" => "45-60",
        "sample_description" => "it is a really great sample",
        "cell_type" => "Stem cell",
        "growth_condition" => "Wildtype",
        "time_point" => "24 hours",
        "sample_type" => "RNA",
        "taxon_id" => 9606,
        "date_of_sample_collection" => "2013-04-25T10:27:00+00:00",
        "is_sample_a_control" => true,
        "is_re_submitted_sample" => false,
        "hmdmc_number" => "number",
        "supplier_sample_name" => "name",
        "common_name" => "human",
        "scientific_name" => "homo sapiens",
        "ebi_accession_number" => "number",
        "sample_source" => "source",
        "mother" => "mother",
        "father" => "father",
        "sibling" => "sibling",
        "gc_content" => "content",
        "public_name" => "name",
        "cohort" => "cohort",
        "storage_conditions" => "conditions"
    })
    
    sample2 = Lims::ManagementApp::Sample.new({
        "sanger_sample_id" => "S2-2",
        "gender" => "Male",
        "state" => "draft",
        "disease_phenotype" => "abnormal",
        "age_band" => "45-100",
        "sample_description" => "it is another really great sample",
        "cell_type" => "Stem cell",
        "growth_condition" => "Wildtype",
        "time_point" => "48 hours",
        "sample_type" => "RNA",
        "taxon_id" => 9606,
        "date_of_sample_collection" => "2013-04-25T10:27:00+00:00",
        "is_sample_a_control" => true,
        "is_re_submitted_sample" => false,
        "hmdmc_number" => "number",
        "supplier_sample_name" => "name",
        "common_name" => "human",
        "scientific_name" => "homo sapiens",
        "ebi_accession_number" => "number",
        "sample_source" => "source",
        "mother" => "mother",
        "father" => "father",
        "sibling" => "sibling",
        "gc_content" => "content",
        "public_name" => "name",
        "cohort" => "cohort",
        "storage_conditions" => "conditions"
    })
    
    save_with_uuid sample => [1,2,3,4,5], sample2 => [1,2,3,4,6]

    header('Accept', 'application/json')
    header('Content-Type', 'application/json')

    response = post "/actions/bulk_update_sample", <<-EOD
    {
    "bulk_update_sample": {
        "updates": {
            "11111111-2222-3333-4444-555555555555": {
                "sanger_sample_id": "S2-1-modified"
            },
            "11111111-2222-3333-4444-666666666666": {
                "sanger_sample_id": "S2-2-modified"
            }
        }
    }
}
    EOD
    response.status.should == 200
    response.body.should match_json <<-EOD
    {
    "bulk_update_sample": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "result": {
            "samples": [
                {
                    "actions": {
                        "read": "http://example.org/11111111-2222-3333-4444-555555555555",
                        "create": "http://example.org/11111111-2222-3333-4444-555555555555",
                        "update": "http://example.org/11111111-2222-3333-4444-555555555555",
                        "delete": "http://example.org/11111111-2222-3333-4444-555555555555"
                    },
                    "uuid": "11111111-2222-3333-4444-555555555555",
                    "state": "draft",
                    "supplier_sample_name": "name",
                    "disease_phenotype": "normal",
                    "age_band": "45-60",
                    "sample_description": "it is a really great sample",
                    "cell_type": "Stem cell",
                    "growth_condition": "Wildtype",
                    "time_point": "24 hours",
                    "gender": "Male",
                    "sanger_sample_id": "S2-1-modified",
                    "sample_type": "RNA",
                    "scientific_name": "Homo sapiens",
                    "common_name": "human",
                    "hmdmc_number": "number",
                    "ebi_accession_number": "number",
                    "sample_source": "source",
                    "mother": "mother",
                    "father": "father",
                    "sibling": "sibling",
                    "gc_content": "content",
                    "public_name": "name",
                    "cohort": "cohort",
                    "storage_conditions": "conditions",
                    "taxon_id": 9606,
                    "volume": null,
                    "date_of_sample_collection": "2013-04-25T10:27:00+00:00",
                    "is_sample_a_control": true,
                    "is_re_submitted_sample": false
                },
                {
                    "actions": {
                        "read": "http://example.org/11111111-2222-3333-4444-666666666666",
                        "create": "http://example.org/11111111-2222-3333-4444-666666666666",
                        "update": "http://example.org/11111111-2222-3333-4444-666666666666",
                        "delete": "http://example.org/11111111-2222-3333-4444-666666666666"
                    },
                    "uuid": "11111111-2222-3333-4444-666666666666",
                    "state": "draft",
                    "sanger_sample_id": "S2-2-modified",
                    "gender": "Male",
                    "disease_phenotype": "abnormal",
                    "age_band": "45-100",
                    "sample_description": "it is another really great sample",
                    "cell_type": "Stem cell",
                    "growth_condition": "Wildtype",
                    "time_point": "48 hours",
                    "sample_type": "RNA",
                    "hmdmc_number": "number",
                    "supplier_sample_name": "name",
                    "common_name": "human",
                    "scientific_name": "Homo sapiens",
                    "ebi_accession_number": "number",
                    "sample_source": "source",
                    "mother": "mother",
                    "father": "father",
                    "sibling": "sibling",
                    "gc_content": "content",
                    "public_name": "name",
                    "cohort": "cohort",
                    "storage_conditions": "conditions",
                    "taxon_id": 9606,
                    "volume": null,
                    "date_of_sample_collection": "2013-04-25T10:27:00+00:00",
                    "is_sample_a_control": true,
                    "is_re_submitted_sample": false
                }
            ]
        },
        "by": null,
        "updates": {
            "11111111-2222-3333-4444-555555555555": {
                "sanger_sample_id": "S2-1-modified"
            },
            "11111111-2222-3333-4444-666666666666": {
                "sanger_sample_id": "S2-2-modified"
            }
        }
    }
}
    EOD

  end
end
