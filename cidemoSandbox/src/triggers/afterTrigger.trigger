trigger afterTrigger on Opportunity (after insert, after update) 
{
	OpportunityTriggerHandler.setHighestValueOpp(Trigger.new);
}