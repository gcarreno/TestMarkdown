{ Implements Forms.Main

  MIT License

  Copyright (c) 2021 Gustavo Carreno <guscarreno@gmail.com>

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
}
unit TM.Forms.Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, PairSplitter, StdCtrls,
  HtmlView;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnPasHTMLDownConvert: TButton;
    btnDelphiMarkdownConvert: TButton;
    hvDelphiMarkdown: THtmlViewer;
    hvPasHTMLDown: THtmlViewer;
    lblPasHTMLDown: TLabel;
    lblDelphiMarkdown: TLabel;
    memPasHTMLDownMarkdown: TMemo;
    memDelphiMarkdownMarkdown: TMemo;
    psMain: TPairSplitter;
    pssPasHTMLDown: TPairSplitterSide;
    pssDelphiMarkdown: TPairSplitterSide;
    procedure btnDelphiMarkdownConvertClick(Sender: TObject);
    procedure btnPasHTMLDownConvertClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

uses
  PasHTMLDown
, MarkdownProcessor
, MarkdownCommonMark
;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormResize(Sender: TObject);
begin
  psMain.Position:= ClientWidth div 2;
end;

procedure TfrmMain.btnPasHTMLDownConvertClick(Sender: TObject);
var
  sHTML: String;
begin
  sHTML:=
  '<html>'+
    '<head>'+
      '<title>pasHTMLdown</title>'+
    '</head>'+
    '<body>'+
      MarkDownToHTML(memPasHTMLDownMarkdown.Text)+
    '</body>'+
  '</html>'
  ;
  hvPasHTMLDown.Clear;
  hvPasHTMLDown.LoadFromString(sHTML);
end;

procedure TfrmMain.btnDelphiMarkdownConvertClick(Sender: TObject);
var
  sHTML: String;
  mp: TMarkdownProcessor;
begin
  mp:= TMarkdownProcessor.CreateDialect(mdCommonMark);
  sHTML:=
  '<html>'+
    '<head>'+
      '<title>delphi-markdown</title>'+
    '</head>'+
    '<body>'+
      mp.process(memDelphiMarkdownMarkdown.Text)+
    '</body>'+
  '</html>'
  ;
  mp.Free;
  hvDelphiMarkdown.Clear;
  hvDelphiMarkdown.LoadFromString(sHTML);
end;

end.

