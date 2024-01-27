public with sharing abstract class InboundAPIHandler {
    public abstract APIResponse getRecords(APIRequest request);
    public abstract APIResponse createRecords(APIRequest request);
    public abstract APIResponse updateCompleteRecords(APIRequest request);
    public abstract APIResponse updatePartialRecords(APIRequest request);
    public abstract APIResponse deleteRecords(APIRequest request);
}