#encoding utf-8

require 'prawn'
require 'prawn/table'
require_relative '../../lib/helper/document_functions'

class CalendarSummary < Prawn::Document
  include DocumentFunctions

  def initialize(calendar_prints)
    @calendar_prints = calendar_prints
    super(
         top_margin: 30,
        page_layout: :landscape,
               info: pdf_info)

    register_fonts
    font('Ubuntu-Mono', size: 10)
    line_items
    pages_numbering
  end

  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      self.row_colors = %w(DDDDDD FFFFFF)
      self.header = true
    end
  end

  def line_item_rows
    [%w(Τίτλος Από Εώς Περιγραφή)] +
        @calendar_prints.map do |cp|
          [cp.title,
           cp.from.strftime('%d-%m-%Y %H:%M'),
           cp.to.strftime('%d-%m-%Y %H:%M'),
           cp.description]
        end
  end

end

if __FILE__ == $0

  require_relative 'calendar_print'

  i1 = CalendarPrintableData.from_hash(
      title: 'a title',
      description: "Το Lorem Ipsum είναι απλά ένα κείμενο χωρίς νόημα για τους επαγγελματίες της τυπογραφίας και στοιχειοθεσίας. Το Lorem Ipsum είναι το επαγγελματικό πρότυπο όσον αφορά το κείμενο χωρίς νόημα, από τον 15ο αιώνα, όταν ένας ανώνυμος τυπογράφος πήρε ένα δοκίμιο και ανακάτεψε τις λέξεις για να δημιουργήσει ένα δείγμα βιβλίου. Όχι μόνο επιβίωσε πέντε αιώνες, αλλά κυριάρχησε στην ηλεκτρονική στοιχειοθεσία, παραμένοντας με κάθε τρόπο αναλλοίωτο. Έγινε δημοφιλές τη δεκαετία του '60 με την έκδοση των δειγμάτων της Letraset όπου περιελάμβαναν αποσπάσματα του Lorem Ipsum, και πιο πρόσφατα με το λογισμικό ηλεκτρονικής σελιδοποίησης όπως το Aldus PageMaker που περιείχαν εκδοχές του Lorem Ipsum.",
      from: DateTime.new(2016, 02, 02, 12, 0, 0, '+2'),
      to: DateTime.new(2016, 02, 02, 14, 0, 0, '+2')
  )

  i2 = CalendarPrintableData.from_hash(
      title: 'Αεροδρόμιο',
      description: "Το Lorem Ipsum είναι απλά ένα κείμενο χωρίς νόημα για τους επαγγελματίες της τυπογραφίας και στοιχειοθεσίας. Το Lorem Ipsum είναι το επαγγελματικό πρότυπο όσον αφορά το κείμενο χωρίς νόημα, από τον 15ο αιώνα, όταν ένας ανώνυμος τυπογράφος πήρε ένα δοκίμιο και ανακάτεψε τις λέξεις για να δημιουργήσει ένα δείγμα βιβλίου. Όχι μόνο επιβίωσε πέντε αιώνες, αλλά κυριάρχησε στην ηλεκτρονική στοιχειοθεσία, παραμένοντας με κάθε τρόπο αναλλοίωτο. Έγινε δημοφιλές τη δεκαετία του '60 με την έκδοση των δειγμάτων της Letraset όπου περιελάμβαναν αποσπάσματα του Lorem Ipsum, και πιο πρόσφατα με το λογισμικό ηλεκτρονικής σελιδοποίησης όπως το Aldus PageMaker που περιείχαν εκδοχές του Lorem Ipsum.",
      from: DateTime.new(2016, 02, 03, 12, 0, 0, '+2'),
      to: DateTime.new(2016, 02, 02, 13, 0, 0, '+2')
  )

  items = []
  items << i1
  items << i2

  CalendarSummary.new(items).render_file('pdfs/test_summary.pdf')

end