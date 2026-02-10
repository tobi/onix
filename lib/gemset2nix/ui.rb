# frozen_string_literal: true

module Gemset2Nix
  # Terminal UI — clean, precise output for a build tool.
  #
  # Aesthetic: monochrome base with amber (#ffb000) accents.
  # Dense where needed (progress), sparse where not (status).
  module UI
    module_function

    def tty? = $stderr.tty?
    def cols = tty? ? (ENV["COLUMNS"] || `tput cols 2>/dev/null`.strip).to_i.clamp(40, 200) : 80

    # ── Colors ────────────────────────────────────────────────────────

    def bold(s)    = tty? ? "\e[1m#{s}\e[0m" : s
    def dim(s)     = tty? ? "\e[2m#{s}\e[0m" : s
    def italic(s)  = tty? ? "\e[3m#{s}\e[0m" : s
    def green(s)   = tty? ? "\e[32m#{s}\e[0m" : s
    def red(s)     = tty? ? "\e[31m#{s}\e[0m" : s
    def yellow(s)  = tty? ? "\e[33m#{s}\e[0m" : s
    def cyan(s)    = tty? ? "\e[36m#{s}\e[0m" : s
    def amber(s)   = tty? ? "\e[38;2;255;176;0m#{s}\e[0m" : s

    # ── Status marks ─────────────────────────────────────────────────

    def ok(msg)    = $stderr.puts "  #{green("✓")} #{msg}"
    def fail(msg)  = $stderr.puts "  #{red("✗")} #{msg}"
    def warn(msg)  = $stderr.puts "  #{yellow("▸")} #{msg}"
    def info(msg)  = $stderr.puts "  #{amber("›")} #{msg}"
    def skip(msg)  = $stderr.puts "  #{dim("○")} #{dim(msg)}"
    def done(msg)  = $stderr.puts "  #{green("●")} #{msg}"

    # Indented detail line
    def step(msg)  = $stderr.puts "    #{msg}"

    # Write to file
    def wrote(path) = $stderr.puts "  #{dim("→")} #{path}"

    # ── Headers ──────────────────────────────────────────────────────

    def header(title)
      $stderr.puts
      $stderr.puts bold(title)
    end

    def subheader(title)
      $stderr.puts "  #{dim("─")} #{title}"
    end

    # ── Divider ──────────────────────────────────────────────────────

    def divider
      $stderr.puts dim("  #{"─" * [cols - 4, 40].min}")
    end

    # ── Summary line ─────────────────────────────────────────────────

    def summary(*parts)
      $stderr.puts
      $stderr.puts "  #{parts.join(dim(" · "))}"
    end

    # ── Elapsed time formatting ──────────────────────────────────────

    def format_time(secs)
      if secs < 1
        "#{(secs * 1000).round}ms"
      elsif secs < 60
        "%.1fs" % secs
      else
        "#{(secs / 60).floor}m%02ds" % (secs % 60).round
      end
    end

    # ── Progress bar ─────────────────────────────────────────────────
    #
    # Thread-safe. Call #advance from worker threads, #finish when done.
    #
    #   progress = UI::Progress.new(total, label: "Fetching")
    #   progress.advance              # success
    #   progress.advance(success: false)  # failure
    #   progress.finish
    #
    # Output:
    #   Fetching  ████████████░░░░░░░░  62%  186/300  3 failed  12s left
    #
    class Progress
      BAR_FILL  = "█"
      BAR_EMPTY = "░"
      BAR_WIDTH = 24

      def initialize(total, label: "")
        @total = [total, 1].max
        @done = 0
        @failed = 0
        @skipped = 0
        @label = label
        @mutex = Mutex.new
        @t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        @last_draw = 0
        @current_name = nil
        draw
      end

      def advance(success: true, skip: false, name: nil)
        @mutex.synchronize do
          if skip
            @skipped += 1
          elsif success
            @done += 1
          else
            @failed += 1
          end
          @current_name = name
          now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
          if now - @last_draw > 0.08 || completed == @total
            draw
            @last_draw = now
          end
        end
      end

      def finish
        @mutex.synchronize { draw }
        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - @t0

        # Clear progress line
        $stderr.print "\r\e[K" if UI.tty?

        parts = []
        parts << "#{@done} done" if @done > 0
        parts << UI.dim("#{@skipped} cached") if @skipped > 0
        parts << UI.red("#{@failed} failed") if @failed > 0
        parts << UI.dim(UI.format_time(elapsed))

        $stderr.puts "  #{@label}  #{parts.join(UI.dim(" · "))}"
      end

      private

      def completed = @done + @failed + @skipped

      def draw
        return unless UI.tty?

        pct = (completed * 100.0 / @total).round
        filled = (completed * BAR_WIDTH / @total).clamp(0, BAR_WIDTH)
        bar = BAR_FILL * filled + BAR_EMPTY * (BAR_WIDTH - filled)

        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - @t0
        rate = completed > 0 ? (completed / elapsed) : 0
        eta = rate > 0 ? ((@total - completed) / rate) : 0

        right = "#{completed}/#{@total}"
        right += "  #{UI.red("#{@failed}✗")}" if @failed > 0
        right += "  #{UI.dim(format_eta(eta))}" if eta > 1 && completed < @total

        label = @label.ljust(12)
        $stderr.print "\r  #{label}#{UI.amber(bar)} #{pct.to_s.rjust(3)}%  #{right}\e[K"
      end

      def format_eta(secs)
        secs < 60 ? "#{secs.round}s left" : "#{(secs / 60).ceil}m left"
      end
    end
  end
end
