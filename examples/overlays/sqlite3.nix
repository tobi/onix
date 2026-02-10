{ pkgs, ruby }:
{
  deps = with pkgs; [ pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
