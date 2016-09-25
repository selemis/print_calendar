#encoding utf-8

require 'prawn'
require_relative '../../lib/helper/document_functions'

class CalendarBooklet < Prawn::Document
  include DocumentFunctions

  def initialize(items)
    super(top_margin: 30,
                info: pdf_info)

    register_fonts

    items.each_with_index do |item, index|
      font('Ubuntu-Mono')

      font('Ubuntu-Mono', size: 30) do
        stroke_color 'ff0000'
        text "#{item.from.strftime('%A %d %B %Y')}", color: '0000FF', align: :center, :mode => :stroke
      end

      # stroke_axis
      stroke_color 'ff0000'
      stroke do
        move_down 10
        horizontal_rule
      end

      move_down 20
      font('Ubuntu-Mono', size: 16) do
        text "<b>#{item.title}</b> (#{item.from.strftime('%d-%m-%Y %H:%M')} - #{item.to.strftime('%d-%m-%Y %H:%M')})", color: '0000FF', inline_format: true
      end

      move_down 30

      text item.description

      start_new_page unless items.size == index + 1
    end

    pages_numbering
  end

end

if __FILE__ == $0

  require_relative 'calendar_print'

  i1 = CalendarPrint.from_hash(
      title: 'a title',
      description: "Το Lorem Ipsum είναι απλά ένα κείμενο χωρίς νόημα για τους επαγγελματίες της τυπογραφίας και στοιχειοθεσίας. Το Lorem Ipsum είναι το επαγγελματικό πρότυπο όσον αφορά το κείμενο χωρίς νόημα, από τον 15ο αιώνα, όταν ένας ανώνυμος τυπογράφος πήρε ένα δοκίμιο και ανακάτεψε τις λέξεις για να δημιουργήσει ένα δείγμα βιβλίου. Όχι μόνο επιβίωσε πέντε αιώνες, αλλά κυριάρχησε στην ηλεκτρονική στοιχειοθεσία, παραμένοντας με κάθε τρόπο αναλλοίωτο. Έγινε δημοφιλές τη δεκαετία του '60 με την έκδοση των δειγμάτων της Letraset όπου περιελάμβαναν αποσπάσματα του Lorem Ipsum, και πιο πρόσφατα με το λογισμικό ηλεκτρονικής σελιδοποίησης όπως το Aldus PageMaker που περιείχαν εκδοχές του Lorem Ipsum.",
      from: DateTime.new(2016, 02, 02, 12, 0, 0, '+2'),
      to: DateTime.new(2016, 02, 02, 14, 0, 0, '+2')
  )

  i2 = CalendarPrint.from_hash(
      title: 'Αεροδρόμιο',
      description: "Το Lorem Ipsum είναι απλά ένα κείμενο χωρίς νόημα για τους επαγγελματίες της τυπογραφίας και στοιχειοθεσίας. Το Lorem Ipsum είναι το επαγγελματικό πρότυπο όσον αφορά το κείμενο χωρίς νόημα, από τον 15ο αιώνα, όταν ένας ανώνυμος τυπογράφος πήρε ένα δοκίμιο και ανακάτεψε τις λέξεις για να δημιουργήσει ένα δείγμα βιβλίου. Όχι μόνο επιβίωσε πέντε αιώνες, αλλά κυριάρχησε στην ηλεκτρονική στοιχειοθεσία, παραμένοντας με κάθε τρόπο αναλλοίωτο. Έγινε δημοφιλές τη δεκαετία του '60 με την έκδοση των δειγμάτων της Letraset όπου περιελάμβαναν αποσπάσματα του Lorem Ipsum, και πιο πρόσφατα με το λογισμικό ηλεκτρονικής σελιδοποίησης όπως το Aldus PageMaker που περιείχαν εκδοχές του Lorem Ipsum.",
      from: DateTime.new(2016, 02, 03, 12, 0, 0, '+2'),
      to: DateTime.new(2016, 02, 02, 13, 0, 0, '+2')
  )

  items = []
  items << i1
  items << i2

  CalendarBooklet.new(items).render_file('pdfs/test_booklet.pdf')

end
