with Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Text_IO, Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO, Ada.Directories, Ada.Direct_IO;
use Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Text_IO, Ada.Strings.Unbounded;

package Logger is
   procedure Write(Message : in out Unbounded_String);
   procedure Read(Component : in Unbounded_String);
   procedure Helper (Texto : in Unbounded_String;Component : in Unbounded_String);
end Logger;
