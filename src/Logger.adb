with Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Text_IO,
     Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO, Ada.Directories,
     Ada.Direct_IO, Ada.Strings.Unbounded.Text_IO;
use  Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Text_IO,
    Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO;

package body Logger is
   FileName : String := "log.txt";

   procedure Write (Message : in out Unbounded_String) is
      use Ada.Text_IO;
      F : Ada.Text_IO.File_Type;
   begin
      Open (File => F, Mode => Append_File, Name => FileName);
      Unbounded_IO.Put_Line (F, Message);
      Close (F);
   end Write;


   procedure Helper (Texto : in Unbounded_String;Component : in Unbounded_String) is
      ContentsStr  : constant String:= To_String(Texto);
      ContentsUn : Unbounded_String;
   begin
      ContentsUn := To_Unbounded_String(ContentsStr(1..8));
      if ContentsUn = Component then
         Put_Line(ContentsStr);
      end if;
   end Helper;

   procedure Read (Component : in Unbounded_String) is
      Filename   : String := "log.txt";
      File       : Ada.Text_IO.File_Type;
      Line_Count : Natural := 0;
   begin
      Ada.Text_IO.Open (File => File,
                        Mode => Ada.Text_IO.In_File,
                        Name => Filename);
      while not Ada.Text_IO.End_Of_File (File) loop
         declare
            Line : String := Ada.Text_IO.Get_Line (File);
         begin
            Helper(To_Unbounded_String(Line),Component);
         end;
      end loop;
      Ada.Text_IO.Close (File);

   end Read;

end Logger;
