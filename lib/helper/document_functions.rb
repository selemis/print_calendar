module DocumentFunctions

  def pdf_info
    {
        :Title => 'Google Calendar',
        :Author => 'Stelios Omirou',
        :Subject => 'Google Calendar',
        :Keywords => 'Google Calendar',
        :Creator => 'Stelios Omirou',
        :Producer => 'Prawn',
        :CreationDate => Time.now
    }
  end

  def register_fonts
    font_families.update('Ubuntu-Mono' => {
                             normal: 'fonts/UbuntuMono-R.ttf',
                             italic: 'fonts/UbuntuMono-RI.ttf',
                             bold: 'fonts/UbuntuMono-B.ttf',
                             bold_italic: 'fonts/UbuntuMono-BI.ttf'
                         })
  end

  def pages_numbering
    string = 'Σελίδα <page> από <total>'
    options = {:at => [bounds.right - 150, 0],
               :width => 150,
               :align => :right,
               :start_count_at => 1, :color => '007700'}
    number_pages string, options
  end

end