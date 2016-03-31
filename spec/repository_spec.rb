describe "The file \"publishers.json\"" do
  before(:all) do
    publishers_file_path = File.join("#{JOURNALS_ROOT}", "publishers.json")
    @publishers_file_exists = File.exist?(publishers_file_path)
    
    @publishers_file_validates = false
    begin
      @publishers = JSON.parse(File.read(publishers_file_path))
      @publishers_file_validates = true
    rescue JSON::ParserError => e
    end
    
    @data_directories = Dir.foreach(JOURNALS_ROOT).select { |subdirectory| File.file? "#{JOURNALS_ROOT}/#{subdirectory}/_template.csl"}
  end

  it "must be present" do
    expect(@publishers_file_exists).to be true
  end

  it "must be valid JSON" do
    if @publishers_file_exists
      expect(@publishers_file_validates).to be true
    end
  end
  
  it "must contain a description for every metadata folder" do
    if @publishers_file_validates
      expect(@data_directories - @publishers.keys).to eq([])
    end
  end
end

