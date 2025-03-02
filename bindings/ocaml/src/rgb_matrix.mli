(** Print available LED matrix options to stdout *)
val print_flags : unit -> unit

(** Configuration options for the LED matrix *)
module Options : sig
  type t
  
  (** Create a new options with default values *)
  val create : unit -> t
  
  (** Set the number of rows (height) of each LED matrix panel (typically 32, 16, or 8) *)
  val set_rows : t -> int -> unit
  
  (** Get the configured number of rows *)
  val get_rows : t -> int
  
  (** Set the number of columns (width) per panel (typically 32, 64, or 40) *)
  val set_cols : t -> int -> unit
  
  (** Get the configured number of columns *)
  val get_cols : t -> int
  
  (** Set the number of displays daisy-chained together (output of one connected to input of next) *)
  val set_chain_length : t -> int -> unit
  
  (** Get the configured chain length *)
  val get_chain_length : t -> int
  
  (** Set the number of parallel chains connected to the Raspberry Pi *)
  val set_parallel : t -> int -> unit
  
  (** Get the configured number of parallel chains *)
  val get_parallel : t -> int
  
  (** Set PWM bits used for output (1-11). Lower values use less CPU and increase refresh rate *)
  val set_pwm_bits : t -> int -> unit
  
  (** Get the configured PWM bits *)
  val get_pwm_bits : t -> int
  
  (** Set time-unit for the on-time in the lowest significant bit in nanoseconds *)
  val set_pwm_lsb_nanoseconds : t -> int -> unit
  
  (** Get the configured PWM LSB nanoseconds *)
  val get_pwm_lsb_nanoseconds : t -> int
  
  (** Set the number of bits to use for time-dithering to achieve higher refresh rate *)
  val set_pwm_dither_bits : t -> int -> unit
  
  (** Get the configured PWM dither bits *)
  val get_pwm_dither_bits : t -> int
  
  (** Set the initial brightness of the panel in percent (1-100) *)
  val set_brightness : t -> int -> unit
  
  (** Get the configured brightness *)
  val get_brightness : t -> int
  
  (** Set scan mode: 0=progressive, 1=interlaced *)
  val set_scan_mode : t -> int -> unit
  
  (** Get the configured scan mode *)
  val get_scan_mode : t -> int
  
  (** Set row address type: 0=direct setting of row, 1=used for panels with A/B addressing (e.g. 64x64) *)
  val set_row_address_type : t -> int -> unit
  
  (** Get the configured row address type *)
  val get_row_address_type : t -> int
  
  (** Set multiplexing type: 0=direct, 1=stripe, 2=checker (typical 1:8) *)
  val set_multiplexing : t -> int -> unit
  
  (** Get the configured multiplexing type *)
  val get_multiplexing : t -> int
  
  (** Set whether to disable hardware pulsing (true=disabled, false=enabled) *)
  val set_disable_hardware_pulsing : t -> bool -> unit
  
  (** Get whether hardware pulsing is disabled *)
  val get_disable_hardware_pulsing : t -> bool
  
  (** Set whether to show refresh rate (true=show, false=hide) *)
  val set_show_refresh_rate : t -> bool -> unit
  
  (** Get whether refresh rate is shown *)
  val get_show_refresh_rate : t -> bool
  
  (** Set whether to inverse colors (true=inverse, false=normal) *)
  val set_inverse_colors : t -> bool -> unit
  
  (** Get whether colors are inversed *)
  val get_inverse_colors : t -> bool
  
  (** Set the RGB sequence for the LED matrix when the panel wiring mixes up colors *)
  val set_led_rgb_sequence : t -> string -> unit
  
  (** Get the configured LED RGB sequence *)
  val get_led_rgb_sequence : t -> string
  
  (** Set the pixel mapper configuration for arranging panels. Format is a semicolon-separated list of mappers *)
  val set_pixel_mapper_config : t -> string -> unit
  
  (** Get the configured pixel mapper configuration *)
  val get_pixel_mapper_config : t -> string
  
  (** Set the panel type for special initialization requirements (e.g. "FM6126" panels) *)
  val set_panel_type : t -> string -> unit
  
  (** Get the configured panel type *)
  val get_panel_type : t -> string
  
  (** Set refresh rate limit in Hz to maintain constant rate on loaded systems (<=0 for no limit) *)
  val set_limit_refresh_rate_hz : t -> int -> unit
  
  (** Get the configured refresh rate limit *)
  val get_limit_refresh_rate_hz : t -> int
  
  (** Set whether to disable busy waiting when limiting refresh rate (true=sleep, false=busy wait) *)
  val set_disable_busy_waiting : t -> bool -> unit
  
  (** Get whether busy waiting is disabled *)
  val get_disable_busy_waiting : t -> bool
  
  (** Set the hardware mapping used for the GPIO pins (e.g. "regular", "adafruit-hat", etc.) *)
  val set_hardware_mapping : t -> string -> unit
  
  (** Get the configured hardware mapping *)
  val get_hardware_mapping : t -> string
end

(** 24-bit RGB color representation *)
module Color : sig
  type t
  
  (** Create a new RGB color initialized to black (0,0,0) *)
  val create : unit -> t
  
  (** Set the red component (0-255) *)
  val set_r : t -> int -> unit
  
  (** Get the red component *)
  val get_r : t -> int
  
  (** Set the green component (0-255) *)
  val set_g : t -> int -> unit
  
  (** Get the green component *)
  val get_g : t -> int
  
  (** Set the blue component (0-255) *)
  val set_b : t -> int -> unit
  
  (** Get the blue component *)
  val get_b : t -> int
end

(** Runtime options to control system-level behavior *)
module RuntimeOptions : sig
  type t
  
  (** Create a new runtime options object with default settings *)
  val create : unit -> t
  
  (** Set GPIO slowdown factor to compensate for faster Raspberry Pi models
      @param n Slowdown factor (0=no slowdown, 1=slowest, range: 0-4) *)
  val set_gpio_slowdown : t -> int -> unit
  
  (** Control whether the process runs as a daemon in the background
      @param b Daemon flag (0=off, 1=on) - when set to 1, the process
         goes into the background and becomes a daemon *)
  val set_daemon : t -> int -> unit
  
  (** Control whether to drop root privileges
      @param b Drop privileges flag (0=off, 1=on) - when set to 1, drops 
         privileges from 'root' to 'daemon' after initializing hardware *)
  val set_drop_privileges : t -> int -> unit
  
  (** Control whether to initialize GPIO pins
      @param b GPIO init flag (0=skip, 1=initialize) - when set to 0, 
         skips the GPIO initialization which is useful for non-Raspberry Pi platforms *)
  val set_do_gpio_init : t -> int -> unit
end

(** Canvas represents the drawing surface for the LED matrix *)
module Canvas : sig
  type t
  
  (** Get the size of the canvas as (width, height) tuple *)
  val get_size : t -> int * int
  
  (** Set pixel at position (x, y) with RGB color values (r, g, b) 
      @param x X coordinate (0 is left edge)
      @param y Y coordinate (0 is top edge)
      @param r Red component (0-255)
      @param g Green component (0-255) 
      @param b Blue component (0-255) *)
  val set_pixel : t -> x:int -> y:int -> r:int -> g:int -> b:int -> unit
  
  (** Set multiple pixels at once in a rectangular region
      @param x X coordinate of top-left corner
      @param y Y coordinate of top-left corner
      @param width Width of the rectangle
      @param height Height of the rectangle
      @param colors Array of Color.t objects in row-major order *)
  val set_pixels : t -> x:int -> y:int -> width:int -> height:int -> Color.t array -> unit
  
  (** Clear the canvas (set all pixels to black) *)
  val clear : t -> unit
  
  (** Fill the canvas with a single RGB color
      @param r Red component (0-255)
      @param g Green component (0-255)
      @param b Blue component (0-255) *)
  val fill : t -> r:int -> g:int -> b:int -> unit
  
  (** Draw a circle
      @param x X coordinate of center
      @param y Y coordinate of center
      @param radius Radius of circle in pixels
      @param r Red component (0-255)
      @param g Green component (0-255)
      @param b Blue component (0-255) *)
  val draw_circle : t -> x:int -> y:int -> radius:int -> r:int -> g:int -> b:int -> unit
  
  (** Draw a line from (x0,y0) to (x1,y1)
      @param x0 X coordinate of start point
      @param y0 Y coordinate of start point
      @param x1 X coordinate of end point
      @param y1 Y coordinate of end point
      @param r Red component (0-255)
      @param g Green component (0-255)
      @param b Blue component (0-255) *)
  val draw_line : t -> x0:int -> y0:int -> x1:int -> y1:int -> r:int -> g:int -> b:int -> unit
end

(** The main RGB LED Matrix controller *)
module Matrix : sig
  type t
  
  (** Create a new RGB LED matrix from configuration options and runtime options
      @param options Matrix configuration options
      @param runtime_options System-level runtime options
      @return A new matrix instance *)
  val create : Options.t -> RuntimeOptions.t -> t
  
  (** Delete the matrix and free all associated resources
      @param matrix The matrix to delete
      @note Always call this before the end of your program to properly reset the hardware *)
  val delete : t -> unit
  
  (** Get the active canvas for drawing on the matrix
      @param matrix The matrix
      @return The currently active canvas
      @note Ownership of returned canvas stays with the matrix, don't manually free it *)
  val get_canvas : t -> Canvas.t
  
  (** Create an off-screen canvas for double-buffering
      @param matrix The matrix
      @return A new off-screen canvas
      @note Ownership of returned canvas stays with the matrix, don't manually free it *)
  val create_offscreen_canvas : t -> Canvas.t
  
  (** Swap the provided off-screen canvas with the currently active one on vsync
      @param matrix The matrix
      @param canvas The off-screen canvas to swap in
      @return The previously active canvas which is now inactive
      @note This blocks until vsync is reached, providing proper timing *)
  val swap_on_vsync : t -> Canvas.t -> Canvas.t
  
  (** Get the current brightness level of the matrix
      @param matrix The matrix
      @return The current brightness value (0-100) *)
  val get_brightness : t -> int
  
  (** Set the brightness level of the matrix
      @param matrix The matrix
      @param brightness New brightness value (0-100) *)
  val set_brightness : t -> int -> unit
end
