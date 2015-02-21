class DigestEnvelope < Struct.new(:data, :total_count, :next_offset, :previous_offset, :first_offset, :last_offset)
end
