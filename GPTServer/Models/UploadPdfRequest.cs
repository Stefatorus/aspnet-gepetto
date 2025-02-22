namespace GPTServer.Models
{
    public class UploadPdfRequest
    {
        public int ConversationId { get; set; }
        public string PdfBase64 { get; set; }
        public string FileName { get; set; }
    }
}