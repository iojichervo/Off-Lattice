#!/usr/bin/env ruby

Shoes.app(title: "Off Lattice", width: 500, height: 425) do
  background(white)
  stack(margin: 8) do
    title("Off Lattice")
  
    flow do
      stack(width: '50%') do
        para "Particles amount (N)"
        @n = edit_line
        @n.text = 100

        para "Grid length (L)"
        @l = edit_line
        @l.text = 20

        para "Particles radius (r)"
        @r = edit_line
        @r.text = 0

        para "Initial speed (v)"
        @v = edit_line
        @v.text = 0.03
      end
      
      stack(width: '50%') do
        para "Radius interaction (rc)"
        @rc = edit_line
        @rc.text = 1

        para "Cells in a row (M)"
        @m = edit_line
        @m.text = 10

        para "Time (t)"
        @t = edit_line
        @t.text = 200

        para "Noise (eta)"
        @noise = edit_line
        @noise.text = 1
      end
    end

    stack(margin_top: 8) do

      button("Submit") do
        `ruby cim/randomstate.rb #{@n.text} #{@l.text} #{@r.text} #{@v.text}`
        @ret = `ruby offlattice.rb #{@m.text} #{@rc.text} #{@v.text} #{@n.text} #{@t.text} #{@l.text} #{@noise.text}`
        @feedback.text = @ret
        Shoes.app(title: "Finished!", width: 180, height: 60) do
          button("Done", margin_left: "60", margin_top: "15") do
            close()
          end
        end
      end

      @feedback = para
    end

  end
end
